-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.abs_abs_le
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
noncomputable def mulComparison (lam : ℕ → ℝ) : mulSymbolDomain lam →ₗ[ℂ] L2Nat := f mulComparison (lam : ℕ → ℝ) : mulSymbolDomain la
