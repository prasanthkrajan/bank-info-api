# Bank Info API

### Development Setup

1. Ensure you run `bundle install`, and `rake db:setup`, prior to `rails s`


### API Endpoints

#### GET /api/v1/users/:id

* retrieves a specific user and related bank details
* e.g: `GET http://localhost:3000/api/v1/users/1`


### API Design Considerations

* made simple with only one endpoint to input a user ID and retrieve bank info of the user
* external API call logic is encapsulated in the `ApiDataRetriever`
* `UserFacade` serves as a front, and handles delegation of data retrieval by passing the right path to the `ApiDataRetriever`
* `UserDetailsPresenter` and `UserAccountDetailsPresenter` handle formatting and retrieval of data, without being coupled and intertwined in the facade, allowing maintainability




