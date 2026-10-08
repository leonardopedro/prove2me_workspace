-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.lagFlux_eval_bound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.HermiteProductCore
open BookProof.NsLagrangianDet
open BookProof.NsLagrangianDetFL



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable (S : LagNsData K)

theorem BookProof.NsLagrangianDetFL.lagFlux_eval_bound (y : Vd (lagDim K)) :
    |(MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (∑ i, lagG S i * pderiv i (lagE S))).re|
      ≤ (2 * S.nu * ∑ j, lam S j)
        * (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) (lagE S)).re := by sorry
