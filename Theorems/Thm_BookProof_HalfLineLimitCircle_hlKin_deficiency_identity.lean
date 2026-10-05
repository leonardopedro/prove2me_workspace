-- Generated from ChapterHalfLineLimitCircle.lean — theorem BookProof.HalfLineLimitCircle.hlKin_deficiency_identity
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
open BookProof.HalfLineLimitCircle



open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

theorem BookProof.HalfLineLimitCircle.hlKin_deficiency_identity (v : hlCore) :
    (inner ℂ (hlKin v) deficiencyVec : ℂ) = Complex.I * inner ℂ (v : HL) deficiencyVec := by sorry
