-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.eval_lagFlux_re
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable (S : LagNsData K)

theorem BookProof.NsLagrangianDetFL.eval_lagFlux_re (z : PIdx K → ℝ) :
    (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagFlux S)).re
      = -(S.nu * ∑ j : DIdx K, lam S j * z (true, j) ^ 2) := by sorry
