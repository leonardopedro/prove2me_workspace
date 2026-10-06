-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.lorentzLie_sum
import Mathlib
import Definitions.Def_ChapterA3e
import Theorems.Thm_BookProof_ChapterA3_lorentzLie_add
import Theorems.Thm_BookProof_ChapterA3_lorentzLie_zero
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (A : ι → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i ∈ s, A i ∈ LorentzLie) : (∑ i ∈ s, A i) ∈ LorentzLie := by

  classical
  induction s using Finset.induction with
  | empty => simpa using lorentzLie_zero
  | insert i s hi ih =>
      rw [Finset.sum_insert hi]
      exact lorentzLie_add (h i (Finset.mem_insert_self i s))
        (ih fun k hk => h k (Finset.mem_insert_of_mem hk))
