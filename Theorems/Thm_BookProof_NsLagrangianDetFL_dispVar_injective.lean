-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.dispVar_injective
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


theorem BookProof.NsLagrangianDetFL.dispVar_injective : Function.Injective (dispVar (K := K)) := by sorry
