-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foMod_eq_conj_mul_foPhase
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_norm_foPhase
import Theorems.Thm_BookProof_QuadratureEsa_foMod_mul_foPhase
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) (i : Fin d) :
    ((foMod b b' i : ℝ) : ℂ) = (starRingEnd ℂ) (foAmp b b' i) * foPhase b b' i := by

  have hpolar := foMod_mul_foPhase b b' i
  have hconj := congrArg (starRingEnd ℂ) hpolar
  rw [map_mul, Complex.conj_ofReal] at hconj
  calc ((foMod b b' i : ℝ) : ℂ)
      = ((foMod b b' i : ℝ) : ℂ) * ((starRingEnd ℂ) (foPhase b b' i) * foPhase b b' i) := by
        rw [conj_mul_self_of_norm_one (norm_foPhase b b' i), mul_one]
    _ = (starRingEnd ℂ) (foAmp b b' i) * foPhase b b' i := by
        rw [← mul_assoc, hconj]
