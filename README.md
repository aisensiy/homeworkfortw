# 程序说明

目录如下

```
├── Guardfile
├── README.md
├── input
├── lib
│   ├── hotel.rb
│   └── input_processor.rb
├── spec
│   ├── lib
│   │   ├── hotel_spec.rb
│   │   └── input_processor_spec.rb
│   └── spec_helper.rb
├── run.rb
```

`run.rb`为主程序。`input`文件为输入。项目采用了 `ruby 1.9`。执行程序请执行

    ruby run.rb < input

程序使用了`rspec`做测试。

## InputProcessor

首先对于输入的处理应该是与真正的业务无关的，因此使用一个独立的类`InputProcessor`来处理。

由于输入可能是错误的，那么我考虑应该在读输入的处理类中给予验证的工作，而不应该传递给真正的业务中。因此在`InputProcessor`中在解析到错误的输入后会抛出异常。而在`run.rb`中捕捉异常跳过错误的输入不影响之后数据的处理。

```
 44       begin
 45         input_processor.parse(line)
 46       rescue RuntimeError
 47         nil
 48       end
```

如果需要新的输入，那么就构建新的`InputProcessor`只要保持和当前`InputProcessor`一样的输出就可以了。

## Hotel

`Hotel#price`可以计算出根据参数情况下的价格。因为宾馆的价格策略应该会非常的灵活，这里的变化是最多的地方。当前是两种条件的组合，那以后可能有更多策略的组合。比如会根据一些节假日来设置不同的价格。我想到的办法是把这些条件用字符串来表示，并按照顺序组合成一个字符串。然后在构建`Hotel`的时候，把策略以`Hash`的形式添加进来。

```
  6     Hotel.new(:name => "Lakewood", :rating => 3, :strategies => {
  7       "regular weekday" => 110,
  8       "regular weekend" => 90,
  9       "rewards weekday" => 80,
 10       "rewards weekend" => 80
 11     }),
```

然后，用这个组合的字符串去这个`Hash`里面取值。

```
18   def price(arg)
19     strategies["#{user_type(arg[:user_type])} #{day_of_week(arg[:day_of_week])}"]
20   end
```

如果有了根据某些特性日期的价格，可以通过修改`price`中字符串的组合方式来达到目的。


