-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.hermiteInner_succ_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

 by
    rw [hermiteInner, hermiteR_succ m, ← gint_sub]
    congr 1
    ring
  have h2 : gint (hermiteR m * (X * h := by sorry
