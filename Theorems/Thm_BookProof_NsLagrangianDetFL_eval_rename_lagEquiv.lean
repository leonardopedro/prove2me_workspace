-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.eval_rename_lagEquiv
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.HermiteProductCore



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable (S : LagNsData K)

theorem BookProof.NsLagrangianDetFL.eval_rename_lagEquiv (y : Vd (lagDim K)) (p : MvPolynomial (PIdx K) ℂ) :
    MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (rename lagEquiv p)
      = MvPolynomial.eval (fun i => (((fun j => y (lagEquiv j)) i : ℝ) : ℂ)) p := by sorry
