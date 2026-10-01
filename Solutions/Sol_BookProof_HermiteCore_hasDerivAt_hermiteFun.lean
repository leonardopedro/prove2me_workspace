-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hasDerivAt_hermiteFun
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hasDerivAt_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
     map_mul, Complex.conj_ofReal]
    ring
  have hzero := ae_eq_zero_of_moments (Lp.memLp u) hmom
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hzero

/-- **The Hermite basis of `L²(ℝ)`.** -/
def hermiteBasis : HilbertBasi :=
  s ℕ ℂ (Lp ℂ 2 (volume : Measure ℝ)) :=
    HilbertBasis.mk orthonormal_hermiteLp hermiteLp_s
