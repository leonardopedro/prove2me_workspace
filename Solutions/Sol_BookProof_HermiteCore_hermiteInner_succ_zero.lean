-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.hermiteInner_succ_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_hermiteR_zero
import Theorems.Thm_BookProof_HermiteCore_gint_zero
import Theorems.Thm_BookProof_HermiteCore_hermiteInner_succ_left
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 by
    rw [hermiteInner, hermiteR_succ m, ← gint_sub]
    congr 1
    ring
  have h2 : gint (hermiteR m * (X * h :=
  ermiteR n - derivative (hermiteR n)))
        = gint (X * hermiteR m * hermiteR n) - gint (hermiteR m * derivative (hermiteR n)) := by
      rw [← gint_sub]
      congr 1
      ring
    rw [h1, hibp, h2]
    ring
