-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.mulHamiltonian_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterFarisLavine
import Theorems.Thm_BookProof_FarisLavine_mulSymbolOp_symmetric
import Theorems.Thm_BookProof_FarisLavine_mulComparison_nonneg
import Theorems.Thm_BookProof_FarisLavine_mulHamiltonian_commForm
import Theorems.Thm_BookProof_FarisLavine_mulComparison_surjective
import Definitions.Def_ChapterBandEnclosure
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FarisLavine





variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat




open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) :
    EssentiallySelfAdjointOn (mulSymbolDomain lam) (mulHamiltonian lam) :=
  essentiallySelfAdjointOn_of_farisLavine (mulHamiltonian lam) (mulComparison lam) 0
      (mulSymbolOp_symmetric lam lam (fun _ => le_rfl))
      (mulSymbolOp_symmetric lam (fun n => |lam n|) (abs_abs_le lam)) le_rfl
      (mulComparison_nonneg lam) (mulComparison_surjective lam)
      (fun x => by rw [mulHamiltonian_commForm lam x]; simp)
