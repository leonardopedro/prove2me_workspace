-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.gint_gaussPolyDeriv_antisymm
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv p * q) = - gint (p * gaussPolyDeriv q) := by

  have hL : gaussPolyDeriv p * q
      = Polynomial.derivative p * q - Polynomial.C (1 / 2) * (Polynomial.X * (p * q)) := by
    unfold gaussPolyDeriv
    ring
  have hR : p * gaussPolyDeriv q
      = p * Polynomial.derivative q - Polynomial.C (1 / 2) * (Polynomial.X * (p * q)) := by
    unfold gaussPolyDeriv
    ring
  have hibp := gint_ibp p q
  have hexp : p * (Polynomial.X * q - Polynomial.derivative q)
      = Polynomial.X * (p * q) - p * Polynomial.derivative q := by ring
  rw [hexp, gint_sub] at hibp
  rw [hL, hR, gint_sub, gint_sub, gint_C_mul]
  linarith
