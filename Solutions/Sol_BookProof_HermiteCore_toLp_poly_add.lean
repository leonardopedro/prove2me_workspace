-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.toLp_poly_add
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_memLp_poly_mul_gaussH
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
ial.coeff_map, Polynomial.coeff_hermite_self]

theorem solution {n k : ℕ} (h : n < k) : (hermiteR n).coeff k = 0 := by
  simp [hermiteR, Polynomial.coeff_map, Polynomial.coeff_hermite_of_lt h]

theorem natDegree_hermi :=
  teR (n : ℕ) : (hermiteR n).natDegree = n := by
    have hinj : Function.Injective ⇑(Int.castRingHom ℝ) := fun a b h => by
      simpa [Int.castRingHom] using h
    rw [hermiteR, Polynomial.natDegree_map_eq_of_injective hinj, Polynomial.natDegree_hermite]
  
  /-- Adding polynomials adds the corresponding `L²` elements. -/
  theorem toLp_poly_add (p q : Polynomial ℝ)
