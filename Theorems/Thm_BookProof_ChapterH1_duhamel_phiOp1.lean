-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.duhamel_phiOp1
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1






open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH1.duhamel_phiOp1 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (g : Fin n → ℂ) (δ : ℝ) :
    (∫ s in (0 : ℝ)..δ, (NormedSpace.exp ((δ - s) • A)).mulVec g)
      = δ • phiOp1 (δ • A) g := by sorry
