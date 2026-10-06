-- Generated from ChapterLorentzGroup.lean — solution of BookProof.LorentzGroup.delta_card_four
import Mathlib
import Definitions.Def_ChapterLorentzGroup
open BookProof.LorentzGroup




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    ({1, eta, -eta, -1} : Finset (Matrix (Fin 4) (Fin 4) ℝ)).card = 4 := by

  rw [Finset.card_insert_of_notMem, Finset.card_insert_of_notMem,
    Finset.card_insert_of_notMem, Finset.card_singleton] <;>
    norm_num [Matrix.one_fin_two, eta]
  · exact ne_of_apply_ne (fun m => m 1 1) (by norm_num)
  · intro h; have := congr_fun (congr_fun h 0) 0; norm_num at this
  · refine ⟨?_, ?_, ?_⟩ <;> intro h <;> have := congr_fun (congr_fun h 0) 0 <;>
      norm_num at this
    exact absurd (congr_fun (congr_fun h 1) 1) (by norm_num)
