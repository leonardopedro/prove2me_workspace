-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hasDerivAt_hermiteFun
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

     map_mul, Complex.conj_ofReal]
    ring
  have hzero := ae_eq_zero_of_moments (Lp.memLp u) hmom
  exact Lp.eq_zero_iff_ae_eq_zero.mpr hzero

/-- **The Hermite basis of `L²(ℝ)`.** -/
def hermiteBasis : HilbertBasi := by sorry
