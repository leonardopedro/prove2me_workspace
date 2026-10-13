-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteNorm_sq
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteNorm_sq (n : ℕ) :
    hermiteNorm n * hermiteNorm n = (n.factorial : ℝ) * Real.sqrt (2 * Real.pi) := by sorry
