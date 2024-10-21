import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () =>
      import('../app/shared/shared.module').then((m) => m.SharedModule),
  },
  {
    path: 'customer',
    loadChildren: () =>
      import('../app/features/customer/customer.module').then(
        (m) => m.CustomerModule
      ),
  },
];

// localhost:4200/customer -> CustomerModule
// localhost:4200/product -> ProductModule
// localhost:4200/homepage -> SharedModule
