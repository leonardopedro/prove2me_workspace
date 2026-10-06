-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.permMat_diagGen_comm
import Mathlib
import Definitions.Def_ChapterA3n
import Theorems.Thm_BookProof_ChapterA3n_permMat_braiding
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (σ : Equiv.Perm (Fin N))
    (A : Matrix (Fin 4) (Fin 4) ℂ) :
    permMat σ * diagGen A = diagGen A * permMat σ := by

  unfold diagGen
  rw [Finset.mul_sum, Finset.sum_mul,
    ← Equiv.sum_comp σ (fun i => tensorPow (fun j => if j = i then A else 1) * permMat σ)]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [permMat_braiding]
  refine congrArg (· * permMat σ) (congrArg tensorPow (funext fun j => ?_))
  simp only [Equiv.Perm.inv_def, Equiv.symm_apply_eq]
