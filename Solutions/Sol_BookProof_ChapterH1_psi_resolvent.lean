-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.psi_resolvent
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
    X v = (γ - z)⁻¹ • v :=
  with eigenvalue `(γ − z)⁻¹`, i.e. `X v = (γ − z)⁻¹ • v`.
  This is the per-component reduction underlying the CFC identity of H1.5.
  -/
  theorem resolvent_eigenvector {F : Type*} [NormedAddCommGroup F] [Norme
