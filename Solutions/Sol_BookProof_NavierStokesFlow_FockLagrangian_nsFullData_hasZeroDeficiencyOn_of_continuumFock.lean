-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.nsFullData_hasZeroDeficiencyOn_of_continuumFock
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_fockLagrangian_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]
variable {Ω : Type*} [MeasurableSpace Ω] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (d : FullEsa.NSFullData F)
    (μ : Measure Ω) {p q dr : Fin 3 → Ω → ℝ} {cf : Ω → ℝ} (hp : ∀ i, Measurable (p i))
    (hq : ∀ i, Measurable (q i)) (hd : ∀ i, Measurable (dr i)) (hc : Measurable cf)
    (force : Fin 3 → ℝ) {nu : ℝ} (hnu : 0 ≤ nu)
    (W : F ≃ₗᵢ[ℂ] Lp ℂ 2 (fockMeasure μ))
    (hmap : ∀ x : d.D, W (x : F) ∈ (fockLagSymbols μ hp hq hd hc force hnu).data.D)
    (hsurj : ∀ y : (fockLagSymbols μ hp hq hd hc force hnu).data.D,
      ∃ x : d.D, W (x : F) = (y : Lp ℂ 2 (fockMeasure μ)))
    (hint : ∀ x : d.D,
      (((fockLagSymbols μ hp hq hd hc force hnu).data.hFull ⟨W (x : F), hmap x⟩ :
        (fockLagSymbols μ hp hq hd hc force hnu).data.D) : Lp ℂ 2 (fockMeasure μ))
        = W ((d.hamiltonian x : F))) :
    HasZeroDeficiencyOn d.D d.hamiltonian :=
  LagrangianEsa.NSFullData.hasZeroDeficiencyOn_of_lagrangian d _ W hmap hsurj hint
      (fockLagrangian_hasZeroDeficiencyOn μ hp hq hd hc force hnu)
