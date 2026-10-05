-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_QuadratureEsa_posL_hermiteCore
import Theorems.Thm_BookProof_QuadratureEsa_momL_hermiteCore
import Theorems.Thm_BookProof_QuadratureEsa_conj_foAmp
import Theorems.Thm_BookProof_HermiteRelative_foOp_apply
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
theorem solution (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    foOp b b' (hermiteCore a)
      = ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                • hermiteMvLp (a + Finsupp.single i 1)
              + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                • hermiteMvLp (a - Finsupp.single i 1)) := by

  rw [foOp_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [posL_hermiteCore, momL_hermiteCore, conj_foAmp, foAmp]
  module
