-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hn_htrunc_sub_le
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_coef_htrunc
import Theorems.Thm_BookProof_HermiteLadder_coef_sub
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : L2d d) (n : ℕ) {F₀ F F' : Finset (Fin d →₀ ℕ)} (hF : F₀ ≤ F)
    (hF' : F₀ ≤ F') :
    hn n (htrunc v F - htrunc v F')
      ≤ ∑' b : {b // b ∉ F₀}, wt n (b : Fin d →₀ ℕ) * ‖coef (b : Fin d →₀ ℕ) v‖ₑ ^ 2 := by

  classical
  refine le_of_le_of_eq ?_
    (tsum_subtype ({b | b ∉ F₀} : Set (Fin d →₀ ℕ)) (fun b => wt n b * ‖coef b v‖ₑ ^ 2)).symm
  refine ENNReal.tsum_le_tsum fun b => ?_
  rw [coef_sub, coef_htrunc, coef_htrunc]
  by_cases hb : b ∈ F₀
  · have h1 : b ∈ F := hF hb
    have h2 : b ∈ F' := hF' hb
    simp [h1, h2]
  · rw [Set.indicator_of_mem (show b ∈ ({b | b ∉ F₀} : Set (Fin d →₀ ℕ)) from hb)]
    gcongr
    by_cases h1 : b ∈ F <;> by_cases h2 : b ∈ F' <;> simp [h1, h2]
