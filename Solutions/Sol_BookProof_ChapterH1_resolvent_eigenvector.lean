-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.resolvent_eigenvector
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
    (T : F →L[ℂ] F) (X : F →L[ℂ] F) (γ z : ℂ) (v : F)
    (hTv : T v = z • v) (hz : γ - z ≠ 0)
    (_hXr : (γ • (1 : F →L[ℂ] F) - T) * X = 1)
    (hXl : X * (γ • (1 : F →L[ℂ] F) - T) = 1) :
    X v = (γ - z)⁻¹ • v := by

  have key : X ((γ - z) • v) = v := by
    convert congr_arg ( fun f => f v ) hXl using 1 ; simp [ sub_smul, hTv ];
  convert congr_arg ( fun x => ( γ - z ) ⁻¹ • x ) key using 1;
  simp [ hz, smul_smul ]
