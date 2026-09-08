-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.natDegree_hermiteR
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore









open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : (hermiteR n).natDegree = n := by

  have hinj : Function.Injective ⇑(Int.castRingHom ℝ) := fun a b h => by
    simpa [Int.castRingHom] using h
  rw [hermiteR, Polynomial.natDegree_map_eq_of_injective hinj, Polynomial.natDegree_hermite]
