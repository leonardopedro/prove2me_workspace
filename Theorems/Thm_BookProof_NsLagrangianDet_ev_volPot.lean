-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.ev_volPot
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.ev_volPot (kappa : ℝ) (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) :
    ev y (volPot kappa kv)
      = ((kappa / 2 * ∑ q ∈ waveSet kv, Complex.normSq (ev y (volCoef kv q)) : ℝ) : ℂ) := by sorry
