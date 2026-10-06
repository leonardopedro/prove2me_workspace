-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.range_bAllR
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution :
    Set.range bAllR = Set.range bHalfR ∪ Set.range b10R ∪ Set.range bPsR := by

  ext x;
  constructor;
  · rintro ⟨ y, rfl ⟩;
    fin_cases y <;> simp [ bAllR, bHalfR, b10R, bPsR, bAll ];
  · rintro ((⟨y, rfl⟩ | ⟨y, rfl⟩) | ⟨y, rfl⟩)
    · fin_cases y
      · exact ⟨0, rfl⟩
      · exact ⟨1, rfl⟩
      · exact ⟨2, rfl⟩
      · exact ⟨3, rfl⟩
    · fin_cases y
      · exact ⟨4, rfl⟩
      · exact ⟨5, rfl⟩
      · exact ⟨6, rfl⟩
      · exact ⟨7, rfl⟩
      · exact ⟨8, rfl⟩
      · exact ⟨9, rfl⟩
    · fin_cases y
      · exact ⟨10, rfl⟩
      · exact ⟨11, rfl⟩
      · exact ⟨12, rfl⟩
      · exact ⟨13, rfl⟩
