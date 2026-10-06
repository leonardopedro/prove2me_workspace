-- Generated from ChapterLorentzRealRepDirect.lean — solution of BookProof.ChapterLorentzRealRepDirect.WFam_conj_invariant
import Mathlib
import Definitions.Def_ChapterLorentzRealRepDirect
import Theorems.Thm_BookProof_ChapterLorentzRealRep_W10_invariant
import Theorems.Thm_BookProof_ChapterLorentzRealRep_WHalf_invariant
import Theorems.Thm_BookProof_ChapterLorentzRealRep_WPs_invariant
open BookProof.ChapterLorentzRealRepDirect



open Matrix Module


open BookProof.ChapterLorentzRealRep BookProof.ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) (i : Fin 4) :
    (WFam i).map (conjL (castR S) (castR (cinv S))) ≤ WFam i := by

  fin_cases i <;> simp only [WFam, 
    ]
  · exact WHalf_invariant S hS
  · exact W10_invariant S hS
  · exact WPs_invariant S hS
  · exact WTwo_invariant S hS
