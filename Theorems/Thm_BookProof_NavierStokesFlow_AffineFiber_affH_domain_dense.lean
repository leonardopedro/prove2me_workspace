-- Generated from ChapterNavierStokesAffineFiberEsa.lean — theorem BookProof.NavierStokesFlow.AffineFiber.affH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

 : ℝ) := hn
  have hmul : 2 * (|C| + 1) < κ * (n : ℝ) := by
    rw [div_lt_iff₀ hκ] at hgt
    linarith [hgt]
  have hC : C ≤ |C| := le_abs_self C
  nlinarith

/-- The finite-mode core is dense, so the affine fiber Hamiltonian is a densely
defined operator a := by sorry
