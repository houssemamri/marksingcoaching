class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    set_quote
  end

  def simple_funnels
    # temp
  end

  private

  def set_quote
    quotes = {
      'Every problem is a gift—without problems we would not grow.' => 'Anthony Robbins',
      'You only have to do a few things right in your life so long as you don’t do too many things wrong.' => 'Warren Buffett',
      'Success usually comes to those who are too busy to be looking for it.' => 'Henry David Thoreau',
      'And the day came when the risk to remain tight in a bud was more painful than the risk it took to blossom.' => 'Anaïs Nin',
      'There’s no shortage of remarkable ideas, what’s missing is the will to execute them.' => 'Seth Godin',
      'I don’t know the word ‘quit.’ Either I never did, or I have abolished it.' => 'Susan Butcher',
      'Far and away the best prize that life offers is the chance to work hard at work worth doing.' => 'Theodore Roosevelt',
      'If you really look closely, most overnight successes took a long time.' => 'Steve Jobs',
      'Almost everything worthwhile carries with it some sort of risk, whether it’s starting a new business, whether it’s leaving home, whether it’s getting married, or whether it’s flying into space.' => 'Chris Hadfield',
      'Even if you are on the right track, you’ll get run over if you just sit there.' => 'Will Rodgers',
      'Forget past mistakes. Forget failures. Forget everything except what you’re going to do now and do it.' => 'William Durant',
      'Imagination is everything. It is the preview of life’s coming attractions.' => 'Albert Einstein',
      'The first one gets the oyster, the second gets the shell.' => 'Andrew Carnegie',
      'The way to get started is to quit talking and begin doing.' => 'Walt Disney',
      'Whether you think you can or whether you think you can’t, you’re right!' => 'Henry Ford',
      'There are no secrets to success. It is the result of preparation, hard work and learning from failure.' => 'Colin Powell',
      'Success is often achieved by those who don’t know that failure is inevitable.' => 'Coco Chanel',
      'Many of life’s failures are people who did not realize how close they were to success when they gave up.' => 'Thomas Edison',
      'I feel that luck is preparation meeting opportunity.' => 'Oprah Winfrey',
      'I never dreamed about success. I worked for it.' => 'Estée Lauder',
      'Yesterday’s home runs don’t win today’s games.' => 'Babe Ruth',
      'The only place where success comes before work is in the dictionary.' => 'Vidal Sassoon'
    }
    rand_quote = quotes.to_a.sample
    @quote = OpenStruct.new({
                              body: rand_quote[0],
                              author: rand_quote[1]
                            })
  end
end
