-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_completeUnitaryFlow
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (U : ℝ → F → F)
    (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖) (hU0 : ∀ v : F, U 0 v = v)
    (hUD : ∀ (t : ℝ) (v : L.D), U t (v : F) ∈ L.D)
    (hderiv : ∀ (v : L.D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (L.hFull ⟨U t (v : F), hUD t v⟩ : F)) t) :
    HasZeroDeficiencyOn L.D L.hFull :=
  _root_.BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_completeUnitaryFlow
      L.D L.hFull U L.dense hnorm hU0 hUD hderiv
