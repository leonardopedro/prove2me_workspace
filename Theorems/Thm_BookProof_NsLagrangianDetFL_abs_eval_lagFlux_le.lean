-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.abs_eval_lagFlux_le
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet
open BookProof.NsLagrangianDetFL

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section


theorem BookProof.NsLagrangianDetFL.abs_eval_lagFlux_le (z : PIdx K → ℝ) :
    |(MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagFlux S)).re|
      ≤ (2 * S.nu * ∑ j, lam S j)
        * (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagEnergy S)).re := by sorry
