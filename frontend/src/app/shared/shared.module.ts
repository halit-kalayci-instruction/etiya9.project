import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { SharedRoutingModule } from './shared-routing.module';
import { NavbarComponent } from './components/navbar/navbar.component';
import { FooterComponent } from './components/footer/footer.component';
import { MainLayoutComponent } from './layouts/main-layout/main-layout.component';
import { HomepageComponent } from './pages/homepage/homepage.component';

@NgModule({
  declarations: [
    NavbarComponent,
    FooterComponent,
    MainLayoutComponent,
    HomepageComponent,
  ], // Bu modülün altındaki (bu modülün sahip oldugu) schematicler (NavbarComponent)
  imports: [CommonModule, SharedRoutingModule], // Bu modülün dışarıdan aldığı modül ya da standalone componentlar.
  exports: [], // Bu modül import edildiğinde dışarıdan hangi schematiclerine erişim açılacak?
})
export class SharedModule {}
