-- Generated from ChapterNavierStokesLagrangianEsa.lean — theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_completeUnitaryFlow
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa




open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)

theorem BookProof.NavierStokesFlow.LagrangianEsa.LagrangianFullData.hasZeroDeficiencyOn_of_completeUnitaryFlow (U : ℝ → F → F)
    (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖) (hU0 : ∀ v : F, U 0 v = v)
    (hUD : ∀ (t : ℝ) (v : L.D), U t (v : F) ∈ L.D)
    (hderiv : ∀ (v : L.D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (L.hFull ⟨U t (v : F), hUD t v⟩ : F)) t) :
    HasZeroDeficiencyOn L.D L.hFull := by sorry
