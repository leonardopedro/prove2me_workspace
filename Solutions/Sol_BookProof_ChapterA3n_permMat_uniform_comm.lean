-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.permMat_uniform_comm
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
    permMat σ * uniform A = uniform A * permMat σ := by

  convert permMat_braiding σ ( fun _ => A ) using 1 <;> rfl
