-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteR_succ
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.hermiteR_succ (n : ℕ) :
    hermiteR (n + 1) = X * hermiteR n - derivative (hermiteR n) := by sorry
