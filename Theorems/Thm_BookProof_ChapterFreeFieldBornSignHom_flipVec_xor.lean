-- Generated from ChapterFreeFieldBornSignHom.lean — theorem BookProof.ChapterFreeFieldBornSignHom.flipVec_xor
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Definitions.Def_ChapterFreeFieldBornSignAction
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignHom

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignAction



theorem BookProof.ChapterFreeFieldBornSignHom.flipVec_xor (b₁ b₂ : Fin n → Bool) :
    flipVec (fun k => xor (b₁ k) (b₂ k)) = flipVec b₁ * flipVec b₂ := by sorry
