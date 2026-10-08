-- Generated from ChapterLorentzRealRepDirect.lean — solution of BookProof.ChapterLorentzRealRepDirect.iSup_WFam_eq_top
import Mathlib
import Definitions.Def_ChapterLorentzRealRepDirect
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_decomposition_top
open BookProof.ChapterLorentzRealRepDirect



open Matrix Module


open BookProof.ChapterLorentzRealRep BookProof.ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull

set_option maxHeartbeats 1000000 in
theorem solution : (⨆ i, WFam i) = ⊤ := by

  convert BookProof.ChapterLorentzRealRepFull.decomposition_top using 1;
  refine le_antisymm ?_ ?_;
  · refine iSup_le ?_;
    intro i; fin_cases i <;> simp only [WFam, Fin.zero_eta, Fin.isValue, cons_val_zero, Fin.mk_one,
        cons_val_one, Fin.reduceFinMk, cons_val, le_sup_right] ;
    · exact le_sup_of_le_left ( le_sup_of_le_left ( le_sup_of_le_left le_rfl ) );
    · exact le_sup_of_le_left ( le_sup_of_le_left ( le_sup_right ) );
    · exact le_sup_of_le_left ( le_sup_of_le_right le_rfl );
  · simp only [iSup, WFam, range_cons, range_empty, Set.union_empty, Set.union_singleton,
      Set.union_insert, sSup_insert, sSup_singleton, sup_le_iff, le_sup_left, and_true];
    exact ⟨ ⟨ le_sup_of_le_right <| le_sup_of_le_right <| le_sup_of_le_right le_rfl,
        le_sup_of_le_right <| le_sup_of_le_right <| le_sup_of_le_left le_rfl ⟩, le_sup_of_le_right
            <| le_sup_of_le_left le_rfl ⟩
