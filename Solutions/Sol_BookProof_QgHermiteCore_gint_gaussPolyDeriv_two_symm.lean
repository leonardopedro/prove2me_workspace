-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.gint_gaussPolyDeriv_two_symm
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_gint_gaussPolyDeriv_antisymm
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv (gaussPolyDeriv p) * q)
      = gint (p * gaussPolyDeriv (gaussPolyDeriv q)) := by

  have h1 := gint_gaussPolyDeriv_antisymm (gaussPolyDeriv p) q
  have h2 := gint_gaussPolyDeriv_antisymm p (gaussPolyDeriv q)
  linarith
