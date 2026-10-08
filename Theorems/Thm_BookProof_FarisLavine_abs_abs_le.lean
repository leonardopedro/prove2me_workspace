-- Generated from ChapterFarisLavine.lean — theorem BookProof.FarisLavine.abs_abs_le
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal


noncomputable def mulComparison (lam : ℕ → ℝ) : mulSymbolDomain lam →ₗ[ℂ] L2Nat := by sorry
