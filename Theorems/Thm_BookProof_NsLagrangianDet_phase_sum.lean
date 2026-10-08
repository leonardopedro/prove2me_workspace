-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.phase_sum
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]


theorem BookProof.NsLagrangianDet.phase_sum {ι : Type*} (s : Finset ι) (w : ι → Fin 3 → ℝ) (a : Fin 3 → ℝ) :
    ∏ i ∈ s, phase (w i) a = phase (∑ i ∈ s, w i) a := by sorry
