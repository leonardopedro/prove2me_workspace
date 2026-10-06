-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.one_add_dispGrad
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.one_add_dispGrad (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ) :
    1 + dispGrad kv y a
      = Matrix.of fun r c => ∑ o : Option (SMode K), ev y (rowCoef kv o r c) * ophase kv a o := by sorry
