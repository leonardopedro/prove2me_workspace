-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteInner_eq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteInner_eq (m n : ℕ) :
    hermiteInner m n = if m = n then (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) else 0 := by sorry