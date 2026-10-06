-- Generated from ChapterNsLagrangianDetConvolution.lean — theorem BookProof.NsLagrangianDet.hasDerivAt_dispField
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet

variable {K : Type*} [Fintype K]



open MvPolynomial Matrix

noncomputable section


theorem BookProof.NsLagrangianDet.hasDerivAt_dispField (kv : K → Fin 3 → ℝ) (y : DIdx K → ℝ) (a : Fin 3 → ℝ)
    (r c : Fin 3) :
    HasDerivAt (fun t : ℝ => dispField kv y (a + t • (Pi.single c (1 : ℝ) : Fin 3 → ℝ)) r)
      (dispGrad kv y a r c) 0 := by sorry
