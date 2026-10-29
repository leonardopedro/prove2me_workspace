-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.lagE_realCoeff
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.YangMillsHermite



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable (S : LagNsData K)

theorem BookProof.NsLagrangianDetFL.lagE_realCoeff : RealCoeff (lagE S) := by sorry
