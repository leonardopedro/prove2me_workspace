-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.pderiv_disp_vsq
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

theorem BookProof.NsLagrangianDetFL.pderiv_disp_vsq (j : DIdx K) :
    pderiv ((false, j) : PIdx K)
      (∑ l : DIdx K, (X (true, l) : MvPolynomial (PIdx K) ℂ) * X (true, l)) = 0 := by sorry
