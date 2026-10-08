-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.ev_volPot
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial Matrix

noncomputable section

variable {K : Type*} [Fintype K]


theorem BookProof.NsLagrangianDet.ev_volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) :
    ev y (volPot kappa kv)
      = ((kappa / 2 * ∑ q ∈ waveSet kv, Complex.normSq (ev y (volCoef kv q)) : ℝ) : ℂ) := by sorry
