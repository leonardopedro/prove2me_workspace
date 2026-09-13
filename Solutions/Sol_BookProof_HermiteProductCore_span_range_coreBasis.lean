-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.span_range_coreBasis
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ)) :
    Submodule.span ℂ (Set.range (coreBasis (d := d) e)) = polyGaussCore (d := d) := by

  rw [coreBasis, HilbertBasis.coe_mk, InnerProductSpace.span_gramSchmidtNormed_range,
    InnerProductSpace.span_gramSchmidt, span_coreFamily]
