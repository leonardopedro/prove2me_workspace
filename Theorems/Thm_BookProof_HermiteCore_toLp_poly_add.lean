-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.toLp_poly_add
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

ial.coeff_map, Polynomial.coeff_hermite_self]

theorem BookProof.HermiteCore.toLp_poly_add {n k : ℕ} (h : n < k) : (hermiteR n).coeff k = 0 := by
  simp [hermiteR, Polynomial.coeff_map, Polynomial.coeff_hermite_of_lt h]

theorem natDegree_hermi := by sorry
