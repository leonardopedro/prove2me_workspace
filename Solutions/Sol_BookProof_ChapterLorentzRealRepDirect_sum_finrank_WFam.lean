-- Generated from ChapterLorentzRealRepDirect.lean — solution of BookProof.ChapterLorentzRealRepDirect.sum_finrank_WFam
import Mathlib
import Definitions.Def_ChapterLorentzRealRepDirect
open BookProof.ChapterLorentzRealRepDirect



open Matrix Module


open BookProof.ChapterLorentzRealRep BookProof.ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull

set_option maxHeartbeats 1000000 in
theorem solution :
    (∑ i, finrank ℝ (WFam i)) = finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ) := by

  convert BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add.symm;
  convert Fin.sum_univ_four _
  all_goals rfl
