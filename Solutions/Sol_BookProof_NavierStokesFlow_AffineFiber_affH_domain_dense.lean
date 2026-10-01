-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.affH_domain_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_lpFiniteModes_dense
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
 : ℝ) := hn
  have hmul : 2 * (|C| + 1) < κ * (n : ℝ) := by
    rw [div_lt_iff₀ hκ] at hgt
    linarith [hgt]
  have hC : C ≤ |C| := le_abs_self C
  nlinarith

/-- The finite-mode core is dense, so the affine fiber Hamiltonian is a densely
defined operator a := nd its essential self-ad
