-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteLp_span_dense
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteLp_span_dense :
    (⊤ : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
      ≤ (Submodule.span ℂ (Set.range hermiteLp)).topologicalClosure := by sorry
