-- Generated from ChapterNsLagrangianDetFarisLavine.lean — theorem BookProof.NsLagrangianDetFL.lagComparison_relBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsLagrangianDetFL

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)



open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section


theorem BookProof.NsLagrangianDetFL.lagComparison_relBound (x : polyGaussCore (d := lagDim K)) :
    ‖lagKoopmanOp S x‖ ≤ ‖lagComparison S x‖ + ‖(x : L2d (lagDim K))‖ := by sorry
